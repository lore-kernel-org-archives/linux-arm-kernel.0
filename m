From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 30 Aug 2016 15:16:42 -0500
Subject: [PATCH 1/2] arm64: kernel: Add SMC Session ID to results
In-Reply-To: <20160823103841.GD8724@red-moon>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
 <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
 <20160822134313.GJ14680@arm.com>
 <20160822140246.GA30923@hector.attlocal.net>
 <20160822145326.GK14680@arm.com>
 <20160823003831.GN6502@codeaurora.org>
 <20160823103841.GD8724@red-moon>
Message-ID: <20160830201642.GD24683@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 11:38:41AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Aug 22, 2016 at 05:38:31PM -0700, Stephen Boyd wrote:
> 
> [...]
> 
> > This all comes about because the firmware generates a session id
> > for the SMC call and jams it in x6. The assembly on the
> > non-secure side is written with a tight loop around the smc
> > instruction so that when the return value indicates
> > "interrupted", x6 is kept intact and the non-secure OS can jump
> > back to the secure OS without register reloading. Perhaps
> > referring to x6 as result value is not correct because it's
> > really a session id that's irrelevant once the smc call
> > completes.
> 
> Sorry I missed this bit. The session id is _generated_ by secure
> firmware (probably only when the value passed in x6 == 0 (?))
> and actually returned to the caller so that subsequent (interrupted)
> calls can re-issue the same value, is that correct ?
> 
> If that's the case the value in x6 is a result value from an SMCCC
> perspective and your current FW is not SMCCC compliant.
> 

So is Will's solution to this ok?  If so I will respin with the minor change to
get it working and resend.  If not, do I roll my own smccc wrapper?

Regards,

Andy
