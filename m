From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Dec 2013 14:02:11 +0000
Subject: [PATCH 02/11] ASoC: ab8500: Revert back to find_next_bit()
In-Reply-To: <s5hzjnwrbq2.wl%tiwai@suse.de>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-3-git-send-email-lee.jones@linaro.org>
 <s5hd2kssu4g.wl%tiwai@suse.de> <20131219164824.GA16145@lee--X1>
 <s5hzjnwrbq2.wl%tiwai@suse.de>
Message-ID: <20131220140211.GG3709@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > Commit '166a34d ASoC: ab8500: Fix invalid cast to long pointer'
> > > > rather carelessly converts find_next_bit() to fls() (find last
> > > > bit set), which are not the same.
> > > 
> > > Does it break on the real machines?
> > 
> > It does, that's how I found the bug.
> > 
> > > fls() behaves differently from find_next_bit(), of course, but in this
> > > case, it should work same in the end, since there are at most two
> > > bits.
> > 
> > Unfortunately it doesn't work at all. This patch brings audio back to
> > a working state. It took me the best part of a day to track down the
> > issue. :(
> 
> Hmm, then isn't the original code rather buggy?
> 
> Check the values set there by ffs(), fls() and the original
> find_next_bit(), especially whether find_next_bit() gives a valid
> value fitting with the mask bits.

I wish I had the time to delve into exactly what's happening. All I
can tell you is your patch broke audio and this one fixes it again. If
you have time for a deep dive and produce a permanent solution I'd be
much obliged and will of course test anything you send me. In the mean
time, this patch should definitely be applied, as sound is crippled
without it. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
