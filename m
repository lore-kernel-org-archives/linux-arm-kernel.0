From: shankar.vk@gmail.com (Uma shankar)
Date: Sun, 19 Sep 2010 20:33:16 +0530
Subject: setting and removing break-point from within kernel
In-Reply-To: <AANLkTi=-Npp=YWqEG6YpQ+EzP0PtMacJaB18roDFZ40E@mail.gmail.com>
References: <AANLkTi=-Npp=YWqEG6YpQ+EzP0PtMacJaB18roDFZ40E@mail.gmail.com>
Message-ID: <AANLkTinHvMZJyKYjCoGecPRV_4U=S8y5_WHN1z8Uq33w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

? ? ? ? I am trying to debug ?a subtle ?timing-dependent ?bug in kernel.

I found that ?if ?I could set up ?a break-point ?from within ?kernel
at run-time, this ?would help.

The condition to trigger is
"If ?0 is written ?at ?virtual address ?0xCEC8F004 , then stop".

The address is on kernel-stack

My ?SOC has a onchip ?JTAG-based ?debug block.

What I have in mind ?is ?to do as ?below -

signed long __sched schedule_timeout(signed long timeout)
{
?struct timer_list timer;
?unsigned long expire;
// some ?kernel code

// setup ?conditional break-point

// some ?kernel code ?runs here
// some ?kernel code
// some ?kernel code

// ?remove ?the break-point

// some ?kernel code ?runs here

}

     Has anyone tried this ?
     Any ideas ?
                                       Thanks
                                       shankar
