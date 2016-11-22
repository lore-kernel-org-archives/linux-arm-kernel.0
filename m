From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 22 Nov 2016 18:01:11 +0100
Subject: [PATCH 5/7] add bindings for stm32 IIO timer drivers
In-Reply-To: <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
Message-ID: <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
>> +     "st,stm32-iio-timer5"
>> +     "st,stm32-iio-timer6"
>> +     "st,stm32-iio-timer7"
>> +     "st,stm32-iio-timer8"
>> +     "st,stm32-iio-timer9"
>> +     "st,stm32-iio-timer10"
>> +     "st,stm32-iio-timer11"
>> +     "st,stm32-iio-timer12"
>> +     "st,stm32-iio-timer13"
>> +     "st,stm32-iio-timer14"
>
> We can't do this. This is a binding for a driver, not for the hardware.
>

Unfortunately each instance for the hardware IP have little
differences like which triggers they could accept or size of the
counter register,
and I doesn't have value inside the hardware to distinguish them so
the only way I found is to use compatible.
