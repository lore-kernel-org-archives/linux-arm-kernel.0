From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 10 Feb 2015 16:28:17 +0800
Subject: arm: kprobe compilation error
In-Reply-To: <54D8934B.6040709@elproma.com.pl>
References: <54D38982.6000100@elproma.com.pl>
 <1423475079.2864.49.camel@linaro.org> <54D8934B.6040709@elproma.com.pl>
Message-ID: <54D9C121.3000601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/9 19:00, Janusz U?ycki wrote:
> 
> W dniu 2015-02-09 o 10:44, Jon Medhurst (Tixy) pisze:
>> Hi Janusz
>>
>> On Thu, 2015-02-05 at 16:17 +0100, Janusz U?ycki wrote:
>>> I got the compilation error on next-20150204:
>>>
>> [...]
>>> In file included from arch/arm/probes/kprobes/core.c:37:
>>> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other
>>> than a declaration
>> [...]
>>> gcc version 4.2.4
>> Thanks for reporting this, is it OK if I add to a patch to fix this a
>> line saying "Reported-by: Janusz U?ycki <j.uzycki@elproma.com.pl>"?
> 
> sure
> 
>>
>> Whilst the extra '*' looks like an obvious typo, it's interesting that
>> your error message implies that it's allowed in some situations and that
>> the version of GCC that I use (4.9.1) doesn't complain about it.
>> If it's valid C, I've no idea what that syntax that might represent.
>>
> I've not find such extension in C11 but likely gcc's team knows the answer.
> It also compiles using gcc 4.8.3. However I thing more people use older compilers
> for different platforms.
> 

Hi All,

Thanks for reporting and fixing this.

When writing this code I checked C spec from open-std (n1548 and n1570). I got an
feeling that [*] should be a standard way to specify variable length array types.
Please see 6.7.6.3 and 6.7.7 of the spec. However I forgot there are old gccs which
don't support that standard.

Thank you!

> best regards
> Janusz
> 
