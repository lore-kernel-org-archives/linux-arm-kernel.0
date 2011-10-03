From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Oct 2011 13:03:00 -0700
Subject: [PATCH] ARM: tegra: Make earlyprintk choose a UART at runtime.
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173A2C6B44@HQMAIL01.nvidia.com>
References: <1317061425-1030-1-git-send-email-dianders@chromium.org>
	<74CDBE0F657A3D45AFBB94109FB122FF173A2C6B44@HQMAIL01.nvidia.com>
Message-ID: <CAD=FV=WxqKX62vM4r=qtQKVmNKbNP2u4jXd35iF4raveOudUqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

OK, thanks for testing!  I will rev the patch and resend in a little bit.

-Doug

---

On Fri, Sep 30, 2011 at 3:11 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Doug Anderson wrote at Monday, September 26, 2011 12:24 PM:
>> With this change we automatically detect which UART to use for
>> earlyprintk (and for printing during decompression). ?The
>> detection involves coordination with the bootloader: it's expected
>> that the bootloader will leave a 'D' (for [D]ebug) in the UART
>> scratchpad register for whichever UART we should use for debugging.
>
> This works fine on Tegra20; there, even if the UART clock is off and/or
> the UART is in reset, you can still read the UART_SCR register (and get
> a bogus value) without the system hanging.
>
> However, I just tested on Tegra30, and the behavior has changed; if either
> a UART is in reset /or/ the UART clock is stopped, then the system hangs
> when UART_SCR is read.
>
> As such, this change will cause Tegra30 to fail to boot. I'd rather it
> was augmented to check the clock enable and module reset bits as well
> as the scratch register value in all cases.
>
> Yes, I know mainline doesn't support Tegra30 yet, but we're very close
> to posting the first few patches to start enabling it, and I wouldn't
> want to break it right before that!
>
> --
> nvpublic
>
>
