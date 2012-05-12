From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 12 May 2012 19:10:06 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FADA5EC.8040807@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <201205041923.07620.arnd@arndb.de>
 <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
 <4FA7F009.5010003@wwwdotorg.org>
 <CAJe_ZheHFP9NZEiZfCvS3LL1k7xamzGq4Oep8gfmPRi6RR7R5Q@mail.gmail.com>
 <4FA94B49.5050500@wwwdotorg.org>
 <CAJe_Zhf0=Qnsgsc7U_GbKxc0_6DKj33QWs0UW2giyrVEjPnrvw@mail.gmail.com>
 <4FAAC111.9020308@wwwdotorg.org>
 <CAJe_Zhcrr2QqoY=H3=3EJLPQBjC3Yc43EDjqYXaNok9-T+=0yw@mail.gmail.com>
 <4FABF445.3030105@wwwdotorg.org>
 <CAJe_ZhduQuHnFyF20VnjZW9uz1szwL6O7=ow+tMqanmeHs58pQ@mail.gmail.com>
 <4FAD6848.40700@wwwdotorg.org>
 <CAJe_Zhc8T-vR8fjFLyT4bz6dj=TUyx0F8k=fAPYn_MnbGW5LBg@mail.gmail.com>
 <4FADA5EC.8040807@wwwdotorg.org>
Message-ID: <CAJe_Zhe61GTQQy+ZCVndAd=mrHxGBqyZ8JGZTSHsvE2XRzfGoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2012 05:21, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/11/2012 03:06 PM, Jassi Brar wrote:
>> On 12 May 2012 00:58, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 05/10/2012 01:59 PM, Jassi Brar wrote:
> ...
>>>>> client0: i2s {
>>>>> ? /* has 2 DMA request output signals: 0, 1 */
>>>>> };
>>>>>
>>>>> client1: spdif {
>>>>> ? /* has 2 DMA request signals: 0, 1 */
>>>>> };
>>>>>
>>>> Do we also need to somehow tag these signals for the client to
>>>> differentiate between TX and RX channel ?
>>>
>>> Yes, the client's DT binding would certainly need to describe how many
>>> DMA request signals its HW generates, and give a unique ID to each. The
>>> driver would need to request a DMA channel for a specific one of its DMA
>>> requests.
>>>
>> Did I read "give a unique ID to each" correctly ?
>
> It'd be unique relative to that individual device or DT node, not at any
> larger scope.
>
OK.

>> Could you please take some time out to jot down an example of how a
>> typical client's dma specifier should look.
>
> With this proposal, I'm not sure that the client DT node would need any
> DMA information at all, at least nothing that identifies which DMA
> controllers, channels, or requests are required to service this
> node/device's DMA requests - that routing information is all represented
> in the DMA controller itself.
>
> (I think Arnd made the following point earlier in this thread):
>
> If you did need to put any other information in DT, then that probably
> would go in the DMA client node, since it'd presumably be the same
> irrespective of which DMA controller got used. However, that information
> presumably wouldn't be needed in DT at all, since the driver would know
> it, since it'd be a facet of the HW.
>
> Note: I'm thinking things like DMA physical address (presumably an
> offset from the reg property), DMA access size (presumably a fixed
> property of the HW), DMA burst size (presumably a property of the HW,
> although at least some HW can be programmed to raise the DMA request
> signal with a varying number of FIFO entries free, so not fixed), etc.
>
Yeah, neither did I think a client node should tell more than IDs of
its channels
- which we now decide to simply mention in its binding.

How do I know if you or someone is interested in reworking the patchset
or want me to give it a try?

Thanks,
Jassi
