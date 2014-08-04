From: geoff@infradead.org (Geoff Levand)
Date: Mon, 04 Aug 2014 10:21:09 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke> <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej> <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej> <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
Message-ID: <1407172869.8971.54.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Mon, 2014-08-04 at 15:46 +0530, Arun Chandran wrote:
> The latest kexec code is working fine in LE/BE mode in UP configuration.
> 
> I had to change kexec-tools code a bit to make sure that "kexec -l"
> is not putting dtb at an area where kernel is building its initial page
> tables.

OK, I'll add in code to handle this.

> Now before trying SMP configuration I want to know whether the below "kexec -e"
> scenarios are valid(required)?
> 
> 1st stage                                  |               2nd stage
> ---------------------------------------------------------------------------------------------
> LE UP                                      |               BE UP
> LE UP                                      |               BE SMP
> LE UP                                      |               LE SMP
> LE SMP                                   |               LE UP
> LE SMP                                   |               BE UP
> LE SMP                                   |               BE SMP

Kexec should work for all combinations of kernel options.  A
bootloader (1st stage) may want to be UP, and custom crash
dump kernels (2nd stage) are generally UP.  UP->UP may have
limited use.  I think all these listed are important to test
though, and going the other way also, so BE-SMP->LE-SMP for
example.

-Geoff
