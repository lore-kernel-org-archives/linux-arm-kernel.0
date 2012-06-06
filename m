From: sdharia@codeaurora.org (Sagar Dharia)
Date: Wed, 6 Jun 2012 01:13:30 -0700 (PDT)
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <20120604171344.GA15837@plastictigers.com>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <20120601001617.GA16311@plastictigers.com>
 <74993ac9d11db0db7080c0864daef397.squirrel@www.codeaurora.org>
 <20120604171344.GA15837@plastictigers.com>
Message-ID: <dd131f3f86e367a47b3528015cde9dd9.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I understand it is not a 1-to-1 mapping. However it *is* used as such:
>
>  wbuf[2] = (u8)((segdist & 0xF00) >> 8) | (slc->prop.prot << 4);
>
> which results in NEXT_DEFINE_CHANNEL messages with an invalid TP
> field.
Yes, thanks for catching this. I will make changes to rectify this.

>
> Yes, my mistake. The driver wouldn't have to poll if there was another
> callback. So I don't see how the completion mechanism is superior: it
> forces a synchronous interface to asynchronous events, or the driver
> developer has to work around it.
The get_logical_address API itself doesn't take completion. Completion is
part of slim_device structure so that the slim_device's driver can wait on
it whenever it needs LA for the first time. (Framework signals completion
on a slim_device when it gets enumerated)
If callback is preferred, I will change it to callback.

Regards-
Sagar

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
