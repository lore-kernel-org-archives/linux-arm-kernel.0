From: dyoung@redhat.com (Dave Young)
Date: Mon, 17 Nov 2014 11:52:44 +0800
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <1415829281.15847.16.camel@smoke>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
 <CAFdej022x_XxqR3NJJkXD60wQHt8Yvs3vZ7nbMQczHP+hWXfCA@mail.gmail.com>
 <1415829281.15847.16.camel@smoke>
Message-ID: <20141117035243.GC3160@darkstar.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/14 at 01:54pm, Geoff Levand wrote:
> Hi Arun, Dave,
> 
> On Fri, 2014-11-07 at 16:31 +0530, Arun Chandran wrote:
> > I have issue in flushing with L3 cache on . kexec does not reboot with L3.
> > Is the above logic of flushing (clean + invalidate) after copying the
> > image data is correct? Is there exist the danger of image data being
> > overwritten by invalid cache lines?
> > 
> > I tried with only invalidate(dc ivac); but that also not seems to be
> > working.
> > 
> > Finally I moved the entire flushing logic before copying then
> > things started working. Please see the code change below.
> 
> I added this with some minor changes.  Please let me know if
> it works for you.

I did not got a full boot log due to efi issues, but I think it works for me
as for this cache issue.

For UEFI, seems you applied Ard's original efi stable mapping patch, but he
has an update version which solves fw_vendor panic etc. I tried but the patchset
can not apply on your tree.

I will have no time to test and work on kexec issues this week. Will try next week
with more testing.

Thanks
Dave
