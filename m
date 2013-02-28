From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 28 Feb 2013 11:34:13 +0800
Subject: [PATCH v10 8/8] usb: chipidea: imx: fix the error that using
 uninitialized pointer
In-Reply-To: <CAB7JpEEuGP2Vo6HMZz30BZgiGQbBYqEVMRFEb7m0MbsC8oDjgQ@mail.gmail.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-9-git-send-email-peter.chen@freescale.com>
 <CAB7JpEEuGP2Vo6HMZz30BZgiGQbBYqEVMRFEb7m0MbsC8oDjgQ@mail.gmail.com>
Message-ID: <20130228033412.GC19387@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 10:07:15PM +0200, Alexander Shishkin wrote:
>    On Feb 27, 2013 8:34 AM, "Peter Chen" <peter.chen@freescale.com> wrote:
>    >
>    > If the core's probe fails, the platform layer may not get core's
> 
>    I think the question we should be asking ourselves here is, why does it
>    fail?

I find this problem just make core probe fails as set dr_mode = "peripheral"
with host-only controller, we should consider such user mistake.

I can move vbus handling to core code as it is core thing to avoid this bug.
But what's your suggestion of platform layer handling when core's probe
fails?

http://marc.info/?l=linux-usb&m=136202110302555&w=2

-- 

Best Regards,
Peter Chen
