From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 28 Oct 2014 12:41:04 -0700
Subject: [PATCH v7 4/7] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <12464460.6zhqY1bzdG@wuerfel>
References: <1414011474-11821-5-git-send-email-sbranden@broadcom.com>
 <12464460.6zhqY1bzdG@wuerfel>
Message-ID: <544FF150.3090504@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.  Will send out v8 version.  Hopefully for finally 
approval.

On 14-10-28 09:10 AM, Arnd Bergmann wrote:
> On Wednesday 22 October 2014 13:57:51 Scott Branden wrote:
>> +
>> +       aliases {
>> +               serial0 = &uart3;
>> +               serial1 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200 earlyprintk debug";
>> +       };
>>
>
> Please move the 'aliases' and 'chosen' node into the .dts files, these
> are board specific, not SoC specific.
ok.
>
> For chosen, please remove earlyprintk and debug, which don't normally
> make sense unless you are debugging, and which will break in a multiplatform
> kernel.
ok.
>
> Please also add an "stdout-path = &uart3" property in chosen so that
> earlycon can work. Note that earlycon is currently broken on arm32,
> but we'll get there.
ok.
>
> 	Arnd
>
