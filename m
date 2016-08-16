From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 16 Aug 2016 08:55:30 +0800
Subject: [rjarzmik:work/v4l2 4/13]
 drivers/media/platform/soc_camera/pxa_camera.c:762:17: error: 'struct
 pxa_camera_dev' has no member named 'v4l2_dev'
Message-ID: <201608160828.WNO954gJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/v4l2
head:   5a679395e20afaffd49629e90734b389bc5dc9fc
commit: e4894e2a23c2d9d85c90c3fb9c459d6676a4b263 [4/13] media: platform: pxa_camera: convert to vb2
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e4894e2a23c2d9d85c90c3fb9c459d6676a4b263
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the rjarzmik/work/v4l2 HEAD 5a679395e20afaffd49629e90734b389bc5dc9fc builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/media/platform/soc_camera/pxa_camera.c: In function 'pxa_camera_init_videobuf2':
>> drivers/media/platform/soc_camera/pxa_camera.c:762:17: error: 'struct pxa_camera_dev' has no member named 'v4l2_dev'
     vq->dev = pcdev->v4l2_dev.dev;
                    ^

vim +762 drivers/media/platform/soc_camera/pxa_camera.c

   756	
   757		vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
   758		vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
   759		vq->drv_priv = pcdev;
   760		vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
   761		vq->buf_struct_size = sizeof(struct pxa_buffer);
 > 762		vq->dev = pcdev->v4l2_dev.dev;
   763	
   764		vq->ops = &pxac_vb2_ops;
   765		vq->mem_ops = &vb2_dma_sg_memops;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30821 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/b9afe7ca/attachment-0001.obj>
