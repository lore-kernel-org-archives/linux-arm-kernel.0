From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 12:53:10 +0200
Subject: [RFC PATCH 02/11] coresight: add CoreSight TMC driver
In-Reply-To: <CANLsYky0keX_z0ZggTxst2SfLxB7i1YgcWBOkiV08KHo8mySSw@mail.gmail.com>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
 <1401457391-12242-3-git-send-email-mathieu.poirier@linaro.org>
 <CACRpkdYnFBP8RbOhePed+sq+tk=syME4Trwtd+PgfAyht+3Zqg@mail.gmail.com>
 <CANLsYky0keX_z0ZggTxst2SfLxB7i1YgcWBOkiV08KHo8mySSw@mail.gmail.com>
Message-ID: <CACRpkdYXD=nxBCZdRKah5xjNRCXtFgXDMRq8WyEtjX09wkeS6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 1:12 AM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On 3 June 2014 03:09, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, May 30, 2014 at 3:43 PM,  <mathieu.poirier@linaro.org> wrote:

>>> +       int                     read_count;
>>
>> Can this really be negative?
>
> It is useful for debugging, as an example see "tmc_release()".  If the
> count drops below '0' there is obviously a problem.  Do you see a cost
> in keeping this as an 'int'?  What do you advise here?

No big deal, keep it.

>> This struct overall could use some kerneldoc.
>
> Would writing a comment for each field qualify?

Like above the struct, see Documentation/kernel-doc-nano-HOWTO.txt

>>> +       drvdata->base = devm_ioremap(dev, res->start, resource_size(res));
>>
>> Use devm_ioremap_resource() instead.
>
> I'm working on it.

Bet it's fininshed now ;-)

Yours,
Linus Walleij
