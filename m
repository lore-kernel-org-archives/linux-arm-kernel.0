From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 5 Dec 2017 15:32:15 +0530
Subject: [PATCH 0/7 v2] net: Fix platform_get_irq's error checking
In-Reply-To: <dc7589c8-33d8-44ba-c6e1-b7a67649709c@cogentembedded.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
 <d4b55643-2f28-d684-0603-83c6f336a23b@cogentembedded.com>
 <dc7589c8-33d8-44ba-c6e1-b7a67649709c@cogentembedded.com>
Message-ID: <3acd99d9-5837-eac4-0125-ae77e1369fbf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,


On Tuesday 05 December 2017 03:27 PM, Sergei Shtylyov wrote:
> On 12/5/2017 12:54 PM, Sergei Shtylyov wrote:
>
>>> The platform_get_irq() function returns negative number if an error
>>> occurs, Zero if No irq is found and positive number if irq gets 
>>> successful.
>>
>>     No, returning 0 is not a failure indication anymore! It used to 
>> be but not any longer...
>
>    And I fixed this function exactly to avoid overly complex error 
> checks (which you're trying to propose here).
>
Thanks for your comment. yes you are right. Now It'll not return 0. It 
will return irq and error as negative.
I will not add a check for 0.
>>> platform_get_irq() error checking for only zero is not correct.
>>
>> [...]
>
> MBR, Sergei
Thank you,
~arvind
