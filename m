From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Dec 2013 23:18:35 +0100
Subject: Freeze on Colibri T20 about 5 minutes after boot (3.13-rc1)
In-Reply-To: <24ee0eea02f6d60e8f67825061720004@agner.ch>
References: <24ee0eea02f6d60e8f67825061720004@agner.ch>
Message-ID: <72170fe5d82a9fbe3aaa4312ec60c097@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-02 20:47, schrieb Stefan Agner:
> Since updating to 3.13-rc1 I experience freezes on my Tegra based module
> after 2-5 minutes after boot up. There is no stacktrace, the serial
> console is dead as well as X turns black. 
> 
> I did a git bisect and could isolate the offending commit:
> f52bb722547f43caeaecbcc62db9f3c3b80ead9b
> ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses

Sorry for suspecting this commit, further testing showed I can reproduce
this on earlier commits too, actually back to 3.12. Bisect was kind of
hard to do since sometimes it took quite a while until a crash
happend... Will do testing again.

Sorry

--
Stefan
