From: robh+dt@kernel.org (Rob Herring)
Date: Sat, 30 Apr 2016 08:23:17 -0500
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
 <20160429224407.GF19428@n2100.arm.linux.org.uk>
 <CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
Message-ID: <CAL_JsqKOwshLWyXr3moMXo8GeDwHgoNRU6gWm3D9WBivoqskEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 6:01 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Fri, Apr 29, 2016 at 3:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> My reply would be... why should MMC have special handling that no
>> other subsystem has?
>
> No other subsystem?
>
> * i2c allows numbering devices by alias
> * rtc allows numbering devices by alias.
> * serial allows numbering devices by alias.
> * spi allows numbering devices by alias.
> * watchdog allows numbering devices by alias.
>
> ...at least that's my impression doing a grep for of_alias_get_id(),
> which I suggested earlier in this thread but apparently wasn't done.

IMO, we should remove most or all of these not add more. We shoud move
to identifying devices by other OS independent means. Peter already
pointed out why serial is a problem.

Rob
