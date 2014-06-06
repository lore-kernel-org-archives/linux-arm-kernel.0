From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 14:59:58 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140606214921.GA10969@quad.lixom.net>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
 <20140606210126.GA10219@quad.lixom.net>
 <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
 <20140606214921.GA10969@quad.lixom.net>
Message-ID: <CAD=FV=WSEBRH-Py8oGXp0soAx_Y=j8NdoX89YiPGYeTBzQdOyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

To add a few things to Olof's comments:

On Fri, Jun 6, 2014 at 2:49 PM, Olof Johansson <olof@lixom.net> wrote:
>> What we can do, though, is to publicly shame you all Google People very
>> strongly for not making firmware updates in the field safer and easier.
>> After all you must all know already that, by definition, software always
>> contains bugs.  The first feature to be tested with a new
>> bootloader/firmware must be the ability to successfully and safely (and
>> securely) update itself.  Especially for a mainstream device like a
>> Chromebook.
>
> The security model of Chrome OS is that it relies on a read-only firmware
> that is later verifying and launching a read-write firwmare. Obviously
> changes to the read-only firwmare is impossible in the field (and only
> done at risk of bricking the device for hobbyists). Some changes are
> not possible to work around in the read-write part of the firmware,
> or for some other reason becomes unfeasible to handle there.
>
> We're working on making the RO portion smaller, so we'll be less exposed
> to this in the future, but that's a feature that will take some time
> to mature.

One thing to be aware is that despite the fact that these machines
just came out, their firmware has been roughly frozen (no major
changes) since last September due to various (non-technical) issues.
We almost got the massive rewrite in before the deadline (talk to
Simon Glass about this) but didn't quite make the deadline.  :(

Note that handling CPU resume in a way that can be updated by RW
firmware is non-trivial and requires some SRAM to be saved across
suspend/resume.  On the original Samsung Chromebook we didn't have
that.  On the Samsung Chromebook 2 we do (yay!) but we didn't realize
it until pretty late in the game.  Sigh.

-Doug
