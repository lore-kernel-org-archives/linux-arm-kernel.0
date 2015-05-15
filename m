From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Fri, 15 May 2015 11:11:14 +0200
Subject: [PATCH net-next 00/11] convert stmmac glue layers into platform
 drivers
In-Reply-To: <5463867.jjPLKQomlR@wuerfel>
References: <1431598266-25736-1-git-send-email-manabian@gmail.com>
 <CAGb2v663efjkwgRjPdxV4CQxeesiu7jxkMf9j_oPU_bSHbNNiA@mail.gmail.com>
 <5555A42B.3040205@st.com> <5463867.jjPLKQomlR@wuerfel>
Message-ID: <5555B832.3080708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On 5/15/2015 10:44 AM, Arnd Bergmann wrote:
> On Friday 15 May 2015 09:45:47 Giuseppe CAVALLARO wrote:
>> Hello
>>
>> On 5/14/2015 5:24 PM, Chen-Yu Tsai wrote:
>>> On Thu, May 14, 2015 at 6:10 PM, Joachim Eastwood <manabian@gmail.com> wrote:
>>>> This patch set aims to convert the current dwmac glue layers into
>>>> proper platform drivers as request by Arnd[1]. These changes start
>>>> from patch 3 and onwards.
>>>>
>>>> Overview:
>>>> Platform driver functions like probe and remove are exported from
>>>> the stmmac platform and then used in subsequent glue later
>>>> conversions. The conversion involes adding the platform driver
>>>> boiler plate code and adding it to the build system. The last patch
>>>> removes the driver from the stmmac platform code thus making it into
>>>> a library for common platform driver functions.
>>>>
>>>> The two first patches adds glue layer for my platform. I chose to
>>>> first add old style glue layer and then convert it. The churn this
>>>> creates is just 3 lines.
>>>>
>>>> I would be very nice if people could test this patch set on their
>>>> respective platform. My testing has been limited to compiling and
>>>> testing on my (LPC18xx) platform. Thanks!
>>
>> I wonder if this will make the compatibility with old
>> platforms (like SH4) not based on DT, where there was not used
>> any glue-logic around the driver and just the platform was the
>> reference.
>
> With patch 11, this gets handled by the dwmac-generic driver.

ok

>
>> To be honest, I prefer to not have the Kconfig options.
>> The device-tree compatibility will select the glue-logic
>> needed and we will just pay some bytes when compile.
>>
>> In my opinion, the Koption(s) introduce a problem when touch
>> the driver and we want to guarantee that, at least,
>> all its parts build fine on all the platforms.
>
> The current model is not scalable and requires modifying the base
> driver for each variation, and the change brings the driver
> in line with how we do things for other platform drivers.
>
> We should always be able to build all soc-specific glue drivers
> with 'allmodconfig' for build testing, and a lot of us run that
> frequently to find regressions.

thx for your prompt feedback

Peppe

>
> 	Arnd
>
>
