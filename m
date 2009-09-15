From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 21:57:05 +0900
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
In-Reply-To: <20090915121539.GO22878@rakim.wolfsonmicro.main>
References: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
	<20090915111204.GJ22878@rakim.wolfsonmicro.main>
	<1b68c6790909150442m5aaf826fy73a9c48bd2fabbf2@mail.gmail.com>
	<20090915121539.GO22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150557q53bf9843g38bf41fcaf5beca3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 9:15 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 08:42:32PM +0900, jassi brar wrote:
>> On Tue, Sep 15, 2009 at 8:12 PM, Mark Brown
>
>> > The mout/fout connection in particular isn't audio local, there's way
>> > more EPLL users than just the audio.
>
>> Ofcourse, but i think those drivers and requirements are far off that
>> may need EPLL.
>
> Are you sure? ?UART, USB, MMC and SPI all have options to clock off EPLL
> - I've worked with designs that were actively using it for at least USB.
In mainline?
All these devices do have option to source from EPLL but they don't
seem to use it.

>> EPLL is a shared but unused resource. Using EPLL gives far more accurate clocks
>> and we shudn't keep hands off just because there is no arbiter.
>
> That doesn't seem like it's going to work so well, especially if Samsung
> are actively pushing more drivers into mainline - if two drivers start
> trying to play about with this simultaneously then what'll happen is
> that users who end up trying to use those drivers together will have to
> deal with the fallout.
as i said in another reply, current set of patches are meant to be as
simple as possible.
once that is done I am all to implement and support new features.

>> If not here, i favor controlling it from machine specific code.
>
> Well, for the EPLL mux/PLL connection I'm not sure why we're not just
> doing it in the default clock setup - I had thought that that was being
> done by default already to be honest but I've not checked.
yes, we can simply do clk_setparent in platform/machine code. thats
what some of
samsung-git drivers do.
