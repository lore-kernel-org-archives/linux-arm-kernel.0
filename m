From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 14:50:39 -0500
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <1593441f-d147-4c91-8aab-8622dd8ced19@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
 <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
 <1593441f-d147-4c91-8aab-8622dd8ced19@lechnology.com>
Message-ID: <b6cd3c47-0df8-266a-2b8d-13c82062b647@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 10:50 AM, David Lechner wrote:
> On 10/24/2016 06:58 AM, Sekhar Nori wrote:
>> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>>
>>> +&ehrpwm1 {
>>> +    status = "disabled";
>>
>> Hmm, disabled? Can you add this node when you actually use it?
>
> Not sure why I have this disabled. Like the gpios, the pwms can be used
> via sysfs, so I would like to leave them.
>

Now I remember why these are disabled. The clock matching is broken. 
Only the first ehrpwm and the first ecap get clocks. The others fail.

I can change these to "okay". It will just result in a kernel error 
message until the clocks are fixed.
