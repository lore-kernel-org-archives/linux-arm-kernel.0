From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 18:13:06 +0100
Subject: [PATCH v3 5/8] ARM: at91: move the restart function to the
 system timer driver
In-Reply-To: <20150115170134.GU3843@piout.net>
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421077023-30954-6-git-send-email-alexandre.belloni@free-electrons.com>
 <54B7ED29.9060700@linaro.org> <20150115170134.GU3843@piout.net>
Message-ID: <20150115171306.GW3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2015 at 18:01:34 +0100, Alexandre Belloni wrote :
> > Mmh, I can't clearly explain why but I have a problem with that.
> > 
> > Can you explain why restart code falls in the clockevents driver ?
> > 
> > 
> 
> That is a temporary location before getting rid of it by writing a
> proper reset driver that will use the same syscon.
> 
> The main goal is to remove mach/at91_st.h and direct accesses to the
> system timer registers.
> 

Just to add that it was not because of laziness but to avoid a
depending on an other subsystem...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
