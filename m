From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 10 Mar 2010 15:41:51 +0530
Subject: [PATCH 04/11] ST SPEAr: Added basic header files for SPEAr
	platform
In-Reply-To: <63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>	
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>	
	<63386a3d1003092140o67a6c943rdee3a6c905cea7ef@mail.gmail.com>	
	<4B973CF6.4030009@st.com>
	<63386a3d1003100131v7027e44cu5031c9ee3bf6ec73@mail.gmail.com>
Message-ID: <4B977067.3050108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2010 3:01 PM, Linus Walleij wrote:
> 2010/3/10 Viresh KUMAR <viresh.kumar@st.com>:
>> Linus Walleij:
>>> If this file is only supposed to be used from plat-spear/time.c, move it down
>>> into plat-spear/gpt.h and #include "gpt.h" so noone else will
>>> accidentally use it.
>>
>> GPT's on SPEAr can be used from time.c, platform specific drivers and machine
>> specific drivers or any driver wishing to use hardware timer.
>> In first two cases "gpt.h" will work, but in rest of cases we need gpt.h to be
>> in plat-spear/include/plat
>>
>> Is it okay?
> 
> If you have or have already planned to write such platform, machine
> or subsystem drivers, it's OK, if there are no such users and you cannot
> easily give one, it's overdesigned IMHO. Some realistic examples of such
> drivers will make me change my mind :-)
> 
> The reason I persist is that I've seen such unutilized timer API:s before and
> no other user than the system timer in sight. I never understood what they
> were to be used for, and I still don't, so help me understand. The kernel
> has many internal timer API:s based on clockevent available already so
> why add yet another, platform-specific one?
> 

As you may have seen in spear.h files in mach folders, we have multiple hardware
timers in our design (3 in spear3xx, 4 in spear6xx and each timer have two
independent channels. That doubles the timers count, so it is 6 and 8).
One timer (or two channels) are used by clock event and clock source, but rest of
the timers are still available. So we need some way to export this functionality
of our hardware. It can be considered simply as a driver for GPT.

What do you say?

viresh.
