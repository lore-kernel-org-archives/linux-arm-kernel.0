From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 18:55:59 +0900
Subject: [PATCH v4 03/13] ARM: dts: exynos4: Use labels for overriding
 nodes in Exynos4210 Origen
In-Reply-To: <55531536.4040608@kernel.org>
References: <1431351773-2031-1-git-send-email-k.kozlowski.k@gmail.com>
 <1431351773-2031-4-git-send-email-k.kozlowski.k@gmail.com>
 <55531536.4040608@kernel.org>
Message-ID: <55531FAF.2000704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 13.05.2015 o 18:11, Kukjin Kim pisze:
> On 05/11/15 22:42, Krzysztof Kozlowski wrote:
>> Usage of labels instead of full paths reduces possible mistakes when
>> overriding nodes.
>>
> 
> In case of this changes, I have no objection.
> But I can't see the 'codec' node you deleted in this patch?

It is under label "mfc". This label was already defined in exynos4.dtsi
before:

>> +&mfc {
>> +	samsung,mfc-r = <0x43000000 0x800000>;
>> +	samsung,mfc-l = <0x51000000 0x800000>;
>> +	status = "okay";
>> +};

> 
> And if possible, can you please put the labels in alphabetically when
> you create this patch again? so that we could find the labels easily...

Yes, when I switched to the "label convention" I put them in
alphabetical order. However I did not re-order other (existing) nodes.
This makes some confusion but I wanted to limit the scope of this change
and do only one thing - switch to "label convention".

Do you want me to reorder alphabetically everything?

Best regards,
Krzysztof
