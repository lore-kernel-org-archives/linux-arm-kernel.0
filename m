From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 3 Jun 2014 15:15:16 -0700
Subject: [PATCH] ARM: mvebu: DT: fix OpenBlocks AX3-4 RAM size
In-Reply-To: <7hzjhtuasd.fsf@paris.lan>
References: <5388ddb9.0458440a.2be7.323c@mx.google.com>
 <1401818320-7202-1-git-send-email-jason@lakedaemon.net>
 <7hzjhtuasd.fsf@paris.lan>
Message-ID: <CAGa+x84ZdQDtpdrxVPY2i9jnvZfug6JnP6Ok=5Tafqy3cbOtdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 11:07 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Jason Cooper <jason@lakedaemon.net> writes:
>
>> The OpenBlocks AX3-4 has a non-DT bootloader.  It also comes with 1GB of
>> soldered on RAM, and a DIMM slot for expansion.
>>
>> Unfortunately, atags_to_fdt() doesn't work in big-endian mode, so we see
>> the following failure when attempting to boot a big-endian kernel:
[...]
>>
>> Fix this by setting a sane default (1 GB) in the dts file.
>>
>> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>
> Tested-by: Kevin Hilman <khilman@linaro.org>

Also FYI, I put a temporary hack into my automated boot setup to use
fdtput to live-patch the openblocks DTB with 1G, and you can see that
openblocks is now passing boot test for big-endian:

   http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003812.html

Also FYI, I added mvebu_v7_defconfig + CONFIG_CPU_BIG_ENDIAN=y to the
mix, so those should start showing up in subsequent boot tests also.

Kevin
