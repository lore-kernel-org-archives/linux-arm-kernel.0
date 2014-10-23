From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 16:08:22 -0700
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <1412893600.31184.1.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com> <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com> <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com> <1412707320.32313.100.camel@smoke>
 <20141007184520.GI27464@redhat.com> <1412712777.32313.130.camel@smoke>
 <20141007202210.GA4236@redhat.com> <1412893600.31184.1.camel@smoke>
Message-ID: <1414105702.23621.12.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Thu, 2014-10-09 at 15:26 -0700, Geoff Levand wrote:
> On Tue, 2014-10-07 at 16:22 -0400, Vivek Goyal wrote:
> > Problem is this that if you put code in kernel once which does something
> > which purgatory ought to do, you will never be able to remove it for
> > backward compatibility reasons. Older versions of kexec-tools will 
> > continue to rely on it. Also how in kernel you would know that now
> > purgatory will take care of this and kernel does not have to worry
> > about something. So it is a good idea to integrate the purgatory support
> > from the very beginning.
> 
> I agree with you.  I will add a purgatory.

I added a purgatory stage to kexec-tools, and verified it works
as expected.  My current kernel patches were generic enough to
support a purgatory stage without any additional changes.  I did
make some minor changes to the kernel comments so they use the
language of loading an 'image' instead of a 'kernel'.

I'll post a V5 kernel series.  Please review and reply with your
ack if you find them acceptable.

-Geoff
