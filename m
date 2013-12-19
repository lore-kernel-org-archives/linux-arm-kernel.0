From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 19 Dec 2013 18:29:09 +0100
Subject: [PATCH 02/11] ASoC: ab8500: Revert back to find_next_bit()
In-Reply-To: <20131219164824.GA16145@lee--X1>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-3-git-send-email-lee.jones@linaro.org>
 <s5hd2kssu4g.wl%tiwai@suse.de> <20131219164824.GA16145@lee--X1>
Message-ID: <s5hzjnwrbq2.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu, 19 Dec 2013 16:48:24 +0000,
Lee Jones wrote:
> 
> > > Commit '166a34d ASoC: ab8500: Fix invalid cast to long pointer'
> > > rather carelessly converts find_next_bit() to fls() (find last
> > > bit set), which are not the same.
> > 
> > Does it break on the real machines?
> 
> It does, that's how I found the bug.
> 
> > fls() behaves differently from find_next_bit(), of course, but in this
> > case, it should work same in the end, since there are at most two
> > bits.
> 
> Unfortunately it doesn't work at all. This patch brings audio back to
> a working state. It took me the best part of a day to track down the
> issue. :(

Hmm, then isn't the original code rather buggy?

Check the values set there by ffs(), fls() and the original
find_next_bit(), especially whether find_next_bit() gives a valid
value fitting with the mask bits.


Takashi
