From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 7 Oct 2014 14:48:13 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <1412707320.32313.100.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com>
 <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com>
 <1412707320.32313.100.camel@smoke>
Message-ID: <20141007184813.GJ27464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 11:42:00AM -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Tue, 2014-10-07 at 09:44 -0400, Vivek Goyal wrote:
> > So as Mark and I discussed need of purgatory code in other mails, are you
> > plannign to enable purgatory on arm64.
> 
> Adding purgatory code to arm64 is low priority, and I currently
> have no plan to do that.  Users are asking for kdump, and proper
> UEFI support, so that is what I will work towards.

kdump will make sure of purgatory too. And there does not seem to be
any logic which verifies the checksums of loaded segments hence reducing
the reliability of kdump operation.

So I think fixing the purgatory part here is a must. It leads to better
design as well as improved reliability for kexec/kdump operations.

Thanks
Vivek
