From: webczat_200@poczta.onet.pl (=?UTF-8?Q?Micha=c5=82_Zegan?=)
Date: Mon, 9 Jan 2017 11:14:53 +0100
Subject: [PATCH] clk: scpi: don't add cpufreq device if the scpi dvfs node
 is disabled
In-Reply-To: <d1cccb6b-e938-6522-c45f-5b613567cb4e@arm.com>
References: <1483706070-12357-1-git-send-email-sudeep.holla@arm.com>
 <d51628d1-c930-ec13-990c-97cc47d80472@poczta.onet.pl>
 <d1cccb6b-e938-6522-c45f-5b613567cb4e@arm.com>
Message-ID: <0393387b-8ed5-f75b-7f69-5c0b06c64cca@poczta.onet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Of course.

W dniu 09.01.2017 o 10:58, Sudeep Holla pisze:
> 
> 
> On 07/01/17 00:44, Micha? Zegan wrote:
>> seems the patch works as intended.
>>
> 
> So, can we take this as
> Tested-by: Micha? Zegan <webczat_200@poczta.onet.pl> ?
> 
>> W dniu 06.01.2017 o 13:34, Sudeep Holla pisze:
>>> Currently we add the virtual cpufreq device unconditionally even when
>>> the SCPI DVFS clock provider node is disabled. This will cause cpufreq
>>> driver to throw errors when it gets initailised on boot/modprobe and
>>> also when the CPUs are hot-plugged back in.
>>>
>>> This patch fixes the issue by adding the virtual cpufreq device only if
>>> the SCPI DVFS clock provider is available and registered.
>>>
>>> Fixes: 9490f01e2471 ("clk: scpi: add support for cpufreq virtual device")
>>> Reported-by: Micha? Zegan <webczat_200@poczta.onet.pl>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Michael Turquette <mturquette@baylibre.com>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 525 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170109/26ff70dd/attachment.sig>
