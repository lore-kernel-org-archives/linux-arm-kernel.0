From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 18 Jan 2016 09:49:56 -0800
Subject: [PATCH v9 4/6] arm64, dt, thunderx: Add initial dts for Cavium
 Thunderx in 2 node topology.
In-Reply-To: <1453134965-6125-5-git-send-email-gkulkarni@caviumnetworks.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-5-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <569D25C4.3060806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2016 08:36 AM, Ganapatrao Kulkarni wrote:
> Adding dt file for Cavium's Thunderx dual socket platform.
>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---
>   arch/arm64/boot/dts/cavium/Makefile             |   2 +-
>   arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts  |  83 +++
>   arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi | 806 ++++++++++++++++++++++++
>   3 files changed, 890 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dts
>   create mode 100644 arch/arm64/boot/dts/cavium/thunder-88xx-2n.dtsi
>

These files are useless, they don't contain device nodes for anything 
other than the UARTs.  There is no existing system that has only UARTs 
and no other devices, so these files cannot be (and can never be) used 
anywhere.

Since the boot firmware in all real, and emulated, systems is supplying 
correct DTBs, we should consider not merging these files, and removing 
the likewise useless thunder-88xx.dts  thunder-88xx.dtsi

David Daney


[...]
