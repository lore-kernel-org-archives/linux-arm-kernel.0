From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 5 Jun 2013 12:11:39 -0700
Subject: Error while running android as guest ---FastModels
In-Reply-To: <CAJ30i6EVdXvbg=42iZ3dZb8ASnpDFvm5ZUUPhjLw8oNk057JQw@mail.gmail.com>
References: <CAJ30i6EVdXvbg=42iZ3dZb8ASnpDFvm5ZUUPhjLw8oNk057JQw@mail.gmail.com>
Message-ID: <20130605191139.GA9640@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 08:31:13PM +0200, Mai Daftedar wrote:
> Dear All,
> 
> After following the "Android on Fast Models" pdf. I managed to successfully
> run android as the host and when running the following command to run
> android as a guest:
> 
> ./qemu-system-arm \
> -vnc :0 \
> -k en-us \
> -enable-kvm \
> -serial stdio \
> -kernel zImage \
> -m 512 -M vexpress-a15 -cpu cortex-a15 \
> -drive file=./android.img,id=virtio-blk,if=none \
> -device virtio-blk,drive=virtio-blk,transport=virtio-mmio.0 \
> -append "virtio_mmio.device=1M at 0x4e000000:74:0 init=/init
> console=ttyAMA0 mem=512M root=/dev/vda rw"
> 
> The following errors appear:
> 
> *device virtio-blk, drive=virtio-blk, transport=virtio-mmio.0: No 'PCI' bus
> found for device "virtio-blk-pci"*
> 
> Any suggestions on what I am missing out
> 

Sounds like you're using the wrong version of QEMU.  For virtio to work
you need to use the rather old kvm-arm-virtio branch in my tree (it may
be replicated elsewhere too).

There is ongoing work to get this support updated to newer QEMU
implementations.

-Christoffer
