From: miaoqing@codeaurora.org (miaoqing at codeaurora.org)
Date: Thu, 24 Nov 2016 14:06:57 +0800
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <aaba8b1e30dd4c22be52e50befb202b2@aptaiexm02f.ap.qualcomm.com>
References: <20161123191539.GF2799@io.lakedaemon.net>
 <20161123195120.GE14217@n2100.armlinux.org.uk>
 <20161123205917.GI2799@io.lakedaemon.net>
 <20161123211745.GF14217@n2100.armlinux.org.uk>
 <20161123214053.GJ2799@io.lakedaemon.net>
 <aaba8b1e30dd4c22be52e50befb202b2@aptaiexm02f.ap.qualcomm.com>
Message-ID: <7aba95bdf0d562f3c9640d533c33e1ca@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> Okay, so i was 0, so running UP probably isn't going to help.  r7 is
>> also spec_priv->rfs_chan_spec_scan.
>> 
>> So, I think the question is... how is this NULL - and has it always
>> been NULL...
> 
> The problem appears to be that ath_cmn_process_fft() isn't called that
> often.  When it is, it crashes in ath_cmn_is_fft_buf_full() because
> spec_priv->rfs_chan_spec_scan is NULL when ATH9K_DEBUGFS=n. :-(
> 
> I'm running with ATH9K_DEBUGFS=y now.  If it goes a couple of days
> without crashing, I'll gin up a patch.
> 

A similar patch was applied to ath-next branch: 
https://patchwork.kernel.org/patch/9431163/.

--
Miaoqing
