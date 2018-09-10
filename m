From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 10 Sep 2018 13:26:47 +0200
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
 <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
 <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
 <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
Message-ID: <CAMRc=McUsDyAfSPAEdDBODQ9QubDPVU-C+j3mJLTC7GEriESfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-10 11:50 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 10:45, Bartosz Golaszewski wrote:
>>>
>>> Yes, this is how it should be!
>>>
>> Any actual reason for not putting these definitions into a separate
>> 'machine' header? This approach is currently used by gpio, pinctrl,
>> iio and regulator framework because most systems use either DT or ACPI
>> and don't need to pull in any stuff aimed at board files.
>
>
> I don't want to create header files specific to usecase!
> Lets keep it simple!
>

I won't argue this point anymore, but I disagree. This is not specific
to a usecase but to a whole family of users that need to a) define
nvmem cells without knowing the provider and b) associate them with
consumers. Something normal providers and consumers are not bothered
by, thus a new header file would be in order.

But as you wish...

Bart
