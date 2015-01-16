From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 11:48:04 +0100
Subject: [RFC 2/2] clocksource: don't suspend/resume when unused
In-Reply-To: <54B8EA54.5020002@linaro.org>
References: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421399874-29119-3-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1501161122320.5526@nanos>
 <20150116103530.GB3843@piout.net> <54B8EA54.5020002@linaro.org>
Message-ID: <20150116104804.GE3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/01/2015 at 11:39:16 +0100, Daniel Lezcano wrote :
> >Isn't that already the case?
> >Right now, if you call clocksource_suspend, it doesn't matter whether
> >the clocksource has an enable or not, it will be suspended. Maybe I'm
> >mistaken but my patch doesn't seem to change that behaviour.
> 
> Actually, if there is no enable/disable callback, then CLOCK_SOURCE_USED
> will be never set, hence the condition will always fail and the suspend
> callback won't be called.
> 

It is set in clocksource_enable/disable, even if there is no
enable/disable callback. I only found direct calls to ->enable() in
timekeeper.c, did I miss some?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
