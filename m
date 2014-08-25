From: dianders@google.com (Doug Anderson)
Date: Mon, 25 Aug 2014 08:25:02 -0700
Subject: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
In-Reply-To: <53FAF8C7.8040007@samsung.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <53FAF8C7.8040007@samsung.com>
Message-ID: <CAD=FV=XbV7R+FqRRucA5Cv2A+=3g8zccASwxcTtJD6YyO-ioCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Mon, Aug 25, 2014 at 1:50 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/25/2014 05:13 PM, Ulf Hansson wrote:
>> On 22 August 2014 20:27, Sonny Rao <sonnyrao@chromium.org> wrote:
>>> On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>>>>> detection.But unfortunately CD# line is on the same voltage rails
>>>>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>>>>> detection will break in these boards.
>
> I didn't know that use CD# line for card detect.
> And if CD# voltage rails and I/O voltage rail are same voltage, it doesn't make sense.
> Which card is used with same voltages? (eMMC? SD? SDIO?)
>
> Well, I have checked Exynos5250 and 5420, but it looks like not same rails.

I'm not sure I totally understood what you said.  In my manual I have
a table titled "Table 2-1 Exynos 5420 Pin List".  Look in this table
for XMMC2CDN and XMMC2DATA_0.  Look to the right of the table and
you'll see the power domain.  For both it shows VDDQ_MMC2.  If that
doesn't mean that the two are in the same voltage domain then I don't
know what does.  Can you point to any examples where they have
different voltage domains?

I agree that what exynos does is not sensible, but that's what it is.


>>>> I am not sure I follow here.
>>>>
>>>> Is the card detect mechanism handled internally by the dw_mmc controller?
>>>
>>> Yes
>
> What card detect mechanism?

The dw_mmc controller has a way to read the card detect, right?
That's internal to the controller.  The alternative would be to use a
generic GPIO for card detect.
