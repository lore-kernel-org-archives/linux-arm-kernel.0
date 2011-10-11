From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Oct 2011 10:30:17 -0500
Subject: [PATCH] gpio: exynos4: Add device tree support
In-Reply-To: <CAJuYYwRwBxkAo2fMfVV9wtQ40XeROAnc-cGJK+cssjuh9px=qQ@mail.gmail.com>
References: <1318320974-9879-1-git-send-email-thomas.abraham@linaro.org>
	<4E945C90.1050601@gmail.com>
	<CAJuYYwRwBxkAo2fMfVV9wtQ40XeROAnc-cGJK+cssjuh9px=qQ@mail.gmail.com>
Message-ID: <4E946109.2000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2011 10:19 AM, Thomas Abraham wrote:
> Hi Rob,
> 
> On 11 October 2011 20:41, Rob Herring <robherring2@gmail.com> wrote:
>> Thomas,
>>
>> On 10/11/2011 03:16 AM, Thomas Abraham wrote:
>>> As gpio chips get registered, a device tree node which represents the
>>> gpio chip is searched and attached to it. A translate function is also
>>> provided to convert the gpio specifier into actual platform settings
>>> for pin function selection, pull up/down and driver strength settings.
>>>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> ---
>>> This patch is based on the latest consolidated Samsung GPIO driver available
>>> in the following tree:
>>>   https://github.com/kgene/linux-samsung.git  branch: for-next
>>>
>>>  .../devicetree/bindings/gpio/gpio-samsung.txt      |   30 +++++++++++
>>>  drivers/gpio/gpio-samsung.c                        |   53 ++++++++++++++++++++
>>>  2 files changed, 83 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>> new file mode 100644
>>> index 0000000..883faeb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>> @@ -0,0 +1,30 @@
>>> +Samsung Exynos4 GPIO Controller
>>> +
>>> +Required properties:
>>> +- compatible: Format of compatible property value should be
>>> +  "samsung,exynos4-gpio-<controller_name>". Example: For GPA0 controller, the
>>> +  compatible property value should be "samsung,exynos4-gpio-gpa0".
>>
>> Isn't gpa0 an instance of the h/w, not a version?
> 
> GPA0 is a instance of the gpio controller. There are several such
> instances and there could be differences in those instances such as
> the number of GPIO lines managed by that gpio controller instance.
> 

That doesn't seem like a reason to have different compatible strings.
Does that affect the programming model of the controller? Unused lines
whether at the board level or SOC level shouldn't really matter.

Rob
