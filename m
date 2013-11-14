From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 14 Nov 2013 17:14:22 +0100
Subject: [PATCH 4/4] arm64: advertise CPU features for modalias matching
In-Reply-To: <20131114152907.GL20261@arm.com>
References: <1384165175-16134-1-git-send-email-ard.biesheuvel@linaro.org>
 <1384165175-16134-5-git-send-email-ard.biesheuvel@linaro.org>
 <20131114152907.GL20261@arm.com>
Message-ID: <CAKv+Gu8ORgnhPpt-mK2cghiP5CpjSQ=L5JwvMu+wYMaDU7xbtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 November 2013 16:29, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Nov 11, 2013 at 10:19:35AM +0000, Ard Biesheuvel wrote:
>> +ssize_t arch_print_cpu_modalias(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +     unsigned int caps;
>> +     ssize_t n;
>> +     int i;
>> +
>> +     /*
>> +      * With 32 features maximum (taking 5 bytes each to print), we don't
>> +      * need to worry about overrunning the PAGE_SIZE sized buffer.
>> +      */
>> +     n = sprintf(buf, "cpu:type:arm64:feature:");
>
> I would use "aarch64" here instead of arm64 for consistency with the
> architecture mode, compiler triplet and ELF_PLATFORM definition in the
> kernel.

OK, I will change that.

Regards,
Ard,
