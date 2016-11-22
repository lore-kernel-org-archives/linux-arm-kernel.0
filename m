From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 22 Nov 2016 11:06:42 +0000
Subject: [PATCH 1/3] of: base: add support to get machine compatible string
In-Reply-To: <CAMpxmJU=wR4mdQr5tpNSv8POirtWXR=_s7D_Q_H=Cuy=W=-Jtw@mail.gmail.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
 <1479811311-3080-2-git-send-email-bgolaszewski@baylibre.com>
 <5ce9fb9f-459a-562b-2e9f-85d35f9ec035@arm.com>
 <CAMpxmJU=wR4mdQr5tpNSv8POirtWXR=_s7D_Q_H=Cuy=W=-Jtw@mail.gmail.com>
Message-ID: <dd85c5f9-0899-7da3-ab58-730107bfb02c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/11/16 10:57, Bartosz Golaszewski wrote:
> 2016-11-22 11:53 GMT+01:00 Sudeep Holla <sudeep.holla@arm.com>:
>>
>>
>> On 22/11/16 10:41, Bartosz Golaszewski wrote:
>>>
>>> Add a function allowing to retrieve the compatible string of the root
>>> node of the device tree.
>>>
>>
>> Rob has queued [1] and it's in -next today. You can reuse that if you
>> are planning to target this for v4.11 or just use open coding in your
>> driver for v4.10 and target this move for v4.11 to avoid cross tree
>> dependencies as I already mentioned in your previous thread.
>
> Rob's patch checks the model first - I'm not sure this is the behavior
> we want here as Sekhar suggested we print the machine compatible.

IIUC, you are replacing of_flat_dt_get_machine_name and
of_machine_get_model_name does exactly same. So I don't see any point in
adding this new function and it's just used for logging purpose.
Also Sekhar just gave example by using just compatible adding that
function in the driver itself.

As Arnd suggested me[1], you should for v4.10 fix it in the driver 
itself to avoid the cross tree dependencies at this point similar to [2]

--
Regards,
Sudeep

[1] 
https://www.mail-archive.com/linuxppc-dev at lists.ozlabs.org/msg111428.html
[2] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1274502.html
