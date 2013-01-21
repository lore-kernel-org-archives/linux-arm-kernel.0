From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 20 Jan 2013 19:48:15 -0800
Subject: [PATCH] of: fix incorrect return value of
 of_find_matching_node_and_match()
In-Reply-To: <50FCB5B9.8000802@gmail.com>
References: <1358619642-23607-1-git-send-email-thomas.abraham@linaro.org>
 <50FC66BA.9030503@gmail.com>
 <CAJuYYwT++66UUT5wdZh=B=VC7s2=T4w0qO6G7CEG6eCHT5WBCg@mail.gmail.com>
 <50FCB5B9.8000802@gmail.com>
Message-ID: <CAJuYYwT_psGiQjpwM0qCvfTAhzLV+Yxjk5sVADO4BSnTSxG5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2013 19:27, Rob Herring <robherring2@gmail.com> wrote:
> On 01/20/2013 03:56 PM, Thomas Abraham wrote:
>> On 20 January 2013 13:50, Rob Herring <robherring2@gmail.com> wrote:
>>> On 01/19/2013 12:20 PM, Thomas Abraham wrote:
>>>> The of_find_matching_node_and_match() function incorrectly sets the matched
>>>> entry to 'matches' when the compatible value of a node matches one of the
>>>> possible values. This results in incorrectly selecting the the first entry in
>>>> the 'matches' list as the matched entry. Fix this by noting down the result of
>>>> the call to of_match_node() and setting that as the matched entry.
>>>
>>> Looks fine, but is this breaking something in 3.8 or can it wait for 3.9?
>>
>> Yes, it can wait for 3.9. I am using this function while adding device
>> tree support for timers on exynos platform which will probably merged
>> in 3.9.
>
> Applied for 3.9. It's in my for-next branch on sources.calxeda.com. This
> is a stable branch.
>
> Rob

Thank you Rob.

Regards,
Thomas.
