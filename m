From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 11 Nov 2014 11:09:55 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <CALT56yOU=cqczdEs=FOgoWUHev1A0gihEpV-XsD5_g_ECz6+Qg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sun, 9 Nov 2014 20:11:27
 +0400")
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 <87lhnlwqm4.fsf@free.fr>
 <CALT56yNOXq-ssvsjafz=ae+uWv1GyscoQ3RQ_h--i740zm4trA@mail.gmail.com>
 <8761epwgni.fsf@free.fr>
 <CALT56yOU=cqczdEs=FOgoWUHev1A0gihEpV-XsD5_g_ECz6+Qg@mail.gmail.com>
Message-ID: <8761emujyk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2014-11-09 0:01 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>    clock                         enable_cnt  prepare_cnt        rate
> accuracy   phase
> ----------------------------------------------------------------------------------------
>  clk_dummy                                0            0           0
>        0 0
>  osc_32_768khz                            3            3    32768000
Here the clock rate should be 1000 times slower, for v3.

>     ppll_147_46mhz                        2            4   147456000
>        0 0
>        AC97                               1            1    12288000
This is not the same value as before, but given that the manual states this
value and that AC97 clock's rate is not used by its driver (probably because the
clock is driven by the codec if I remember correctly), that will stay this way.

>        0 0
>        I2S                                0            0   147456000
Here to clock rate is 10 times too quick, for v3.

Cheers.

-- 
Robert
