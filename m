From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 09 Aug 2013 16:21:32 +0300
Subject: [PATCH v14 06/12] usb: chipidea: add flag
 CI_HDRC_DUAL_ROLE_NOT_OTG
In-Reply-To: <20130809111352.GA24763@shlinux1.ap.freescale.net>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
 <1375432445-31918-7-git-send-email-peter.chen@freescale.com>
 <87fvujauqr.fsf@ashishki-desk.ger.corp.intel.com>
 <20130809111352.GA24763@shlinux1.ap.freescale.net>
Message-ID: <877gfvatk3.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Fri, Aug 09, 2013 at 03:55:56PM +0300, Alexander Shishkin wrote:
>> > +		} else {
>> > +			/*
>> > +			 * If the controller is not OTG capable, but support
>> > +			 * role switch, the defalt role is gadget, and the
>> > +			 * user can switch it through debugfs (proc in future?)
>> 
>> It's not going to be in procfs ever, so that part of the comment can go.
>> 
>
> I can delete now, but the role switch does not a debug function, we
> may not put it at debugfs, do you think so?

Even if we were to put the role switch elsewhere, it wouldn't be
procfs.

If there is indeed a hardware platform that intentionally allows
software to select the role, then yes. Right now, it is a debugging
feature.

Regards,
--
Alex
