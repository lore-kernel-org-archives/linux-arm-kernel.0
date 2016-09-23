From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Sep 2016 22:33:47 +0900
Subject: [PATCH] i2c: uniphier-f: fix misdetection of incomplete STOP
 condition
In-Reply-To: <20160923121245.GA1580@katana>
References: <1474632241-10440-1-git-send-email-yamada.masahiro@socionext.com>
 <20160923121245.GA1580@katana>
Message-ID: <CAK7LNAT_Kqm3t_pXuqKxG_p=N504NRKWKoVAFRiv0Fq1LHJQBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,


2016-09-23 21:12 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Fri, Sep 23, 2016 at 09:04:01PM +0900, Masahiro Yamada wrote:
>> Currently, the status register FI2C_SR is checked immediately after
>> a STOP condition is issued in case of the deferred STOP condition.
>> It takes typically 5-10 usec until the corresponding bits in the
>> register are set, so the error check for "stop condition was not
>> completed" is very likely to be false positive.
>>
>> Add wait code to relax the status register check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Use readl_poll_timeout?
>

Yes, thanks for your advice!



-- 
Best Regards
Masahiro Yamada
