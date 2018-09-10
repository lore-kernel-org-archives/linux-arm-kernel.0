From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 10 Sep 2018 11:45:48 +0200
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
 <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
Message-ID: <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-10 10:55 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 09:23, Boris Brezillon wrote:
>>
>> Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
>> should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
>> everything that is related to cell creation should be placed in
>> nvmem-provider.h.
>
> Yes, this is how it should be!
>

Any actual reason for not putting these definitions into a separate
'machine' header? This approach is currently used by gpio, pinctrl,
iio and regulator framework because most systems use either DT or ACPI
and don't need to pull in any stuff aimed at board files.

Bart
