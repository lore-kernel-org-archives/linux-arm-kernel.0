From: carlo@caione.org (Carlo Caione)
Date: Fri, 29 May 2015 19:53:21 +0200
Subject: [PATCH v2 2/3] clk: meson: Document bindings for Meson8b clock
 controller
In-Reply-To: <20150528215731.GD24204@codeaurora.org>
References: <1431773333-23567-1-git-send-email-carlo@caione.org>
 <1431773333-23567-3-git-send-email-carlo@caione.org>
 <20150528215731.GD24204@codeaurora.org>
Message-ID: <CAOQ7t2aNvuxjLuADMn+6jQqjXuQfXwU1P_vcgfoHDmt9ZTcKZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 11:57 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> +
>> +Example: Clock controller node:
>> +
>> +     clkc: clock-controller at c1104000 {
>
> The address after the '@' should be the first reg property.
>
>> +             #clock-cells = <1>;
>> +             compatible = "amlogic,meson8b-clkc";
>> +             reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
>
> And a reg property of length 0x4 looks like it may be part of
> some other "device". Should the xtal register be part of a syscon
> that this node has a phandle to?

Probably it does. But I don't have any documentation about this
device. Also the registers mapped before and after this specific
register in the same memory region seem to not be used at all by the
code in the Amlogic SDK. So I guess I can safely map that specific
register for XTAL.

-- 
Carlo Caione
