From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Jun 2018 16:10:24 -0700
Subject: [PATCH] ARM64: dts: meson-axg: fix ethernet stability issue
In-Reply-To: <d59a60d1-d5fc-6d89-f89b-148c8e3f3521@baylibre.com> (Neil
 Armstrong's message of "Tue, 26 Jun 2018 10:07:26 +0200")
References: <20180625125653.3404-1-jbrunet@baylibre.com>
 <d59a60d1-d5fc-6d89-f89b-148c8e3f3521@baylibre.com>
Message-ID: <7h6023keqn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 25/06/2018 14:56, Jerome Brunet wrote:
>> Like the odroid-c2 and wetek, the s400 uses the RTL8211F and seems to
>> suffer from the kind of stability issue.
>> 
>> Doing an iperf3 download test, we can see a significant number of LPI
>> interrupts on the tx path. After a short while (5 to 15 seconds), the
>> network connection dies. If using rootfs over NFS, the connection may
>> also break during the boot sequence.
>> 
>> We still don't have a real explanation for this problem so let's disable
>> EEE once again.
>> 
>> Fixes: f6f6ac914b82 ("ARM64: dts: meson-axg: enable ethernet for A113D S400 board")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
> [...]
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.18/fixes (which I'll be sending upstream today.)

Kevin
