From: hongjiujing@gmail.com (tommy tommy)
Date: Fri, 6 Nov 2009 11:26:21 +0800
Subject: Suggestion:S3C64XX and next-S3C MFC need IOCTL_MFC_RESET ?
Message-ID: <48cbf6bf0911051926k2464d4e1sfea713cb61d25705@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 hi,emailist!

  I think S3C64XX and next-s3c MFC driver need IOCTL_MFC_RESET,because if
APP unlegal exit mfc operation or MFC met some uncorrect h264/mpeg4/vc1/wmv9
media stream,can cause MFC inter unit become uncorrect state,it need RESET
to recover to work for next!When under that uncorrect condition,APP must use
ioctl_MFC_RESET to recover!

 i have test it ,also OK even met uncorrect stream and unlegal app file
descriptor exit !



patch may be similiar as following:

               /*For MFC RESET,when met uncorrect stram or unlegal file
descriptor exit ,for APP engineer*/
                case IOCTL_MFC_RESET:
                        MFC_Mutex_Lock();

                        MFC_HW_Init(); /*RESET MFC,download firmware ,reset
mfc busy flag*/

                        MFC_Mutex_Release();
                        break;


Tommy at China
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091106/0fe0973d/attachment-0001.htm>
