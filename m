From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:46:58 +0100
Subject: [PATCH v6 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <235181230.251177.1435088854197.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7C92.2040102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 20:47, Stefan Wahren wrote:
>> 0001000
>> >
> i want to port OCOTP driver for MXS, which hasn't MMIO. From my understanding
That's cool.

> hexdump would readout the complete register range defined in provider DT node.
>
> How can i achieve that hexdump only reads the data area within the register
> range?

If the question is just about hexdump, then hexdump itself can read file 
from given offset and size.

But I believe the real question is "How can we dump each nvmem cell 
independently"

In one of my replies I mentioned that am planning to add sysfs entries 
under /sys/class/nvmem/<provider>/cells/

ex:
for qfprom tsens calibration it would look like:

$ hexdump /sys/class/nvmem/qfprom0/cells/tsens_calibration

0000000 e000 0c00 0c00 0000 0c00
...

Is that what you guys are looking for?

--srini
>
> Stefan
