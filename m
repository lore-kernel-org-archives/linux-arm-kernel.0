From: kispalsz@gmail.com (Kispal Szabolcs)
Date: Thu, 29 Mar 2012 22:57:41 +0200
Subject: s3c_otghcd and ECONNRESET
Message-ID: <CAHVpurpt38QcAi4zPg+WL05YCd0id4D=ffoGntR=dqUcviHN4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Sorry for my bad english.
I have a Android Phone. Samsung Galaxy Note. P/n: GT-N7000.  I have to
solve the external camerastream play on lcd.


I used samsung opensource update 1. version: 2.6.35.7
I set uvcvideo as modul.
 <*>     S3C USB OTG Host support
   <*>   USB Gadget Support  --->

   USB Peripheral Controller (S3C HS USB OTG Device)  --->    .
   USB Gadget ( Android gadget)

The kernel works correct. The phone boots up.  I can load modul :
insmod uvcvideo.

I have one problem.

The external (UVC) camera is not recognized on my Android phone. I
have asked uvc development. You can see below my emails with uvc
developers. (2 mail)

They have told me:
"-104 is -ECONNRESET. This is a low-level USB issue, possibly related to your
USB controller. I'm afraid I have no experience with the S3C USB OTG
controller. You might have more luck on the linux-usb mailing list (make sure
you mention s3c_otghcd and ECONNRESET in your mail subject)."

I think, that the problem is : my device support only isochronous mode.
I attatch lsusb log from usb uvc extarnal camera.

Please help me, that this problem is:

a: hw problem, my phone will never  support this mod .
b: my hw support this mod,only in recent driver ( s3c_hsotg.c)  is not
supported.
c: you have patch to  this mod :)   ( i hope)
d:Maybe, another thing cause "ECCONNRESET Problem".

Please help me asap, because this solution is very important for me. I
have to write one apk. on the phone what use external camera.  I can't
start writting of application.

e:Can you see other solution for my problem?

Thank you for your help.
Regards, Szabolcs








On 27.03.2012 23:55, Kispal Szabolcs wrote:
> ---------- Forwarded message ----------
> From: Kispal Szabolcs<kispalsz@gmail.com>
> Date: 2012/3/27
> Subject: UVC failed to initialize the device
> To: linux-uvc-devel at lists.sourceforge.net
>
>
> Hello,
> can You help me?
>
> Sorry my bad english. :)
>
> I have a camera. I use this on linux pc. ( ubuntu 10.04.04) . On Linux PC
> work correct. I use this camera with VLC, and i see the videostream from
> camera. I attach lsusb output.
>
> I want to use this camera on Android phone. This phone is Samsung Galaxy
> Note.
> I compiled my own  kernel from samsung opensource with uvcvideo as modul.
>
> I can load the modul on Android device:
> insmod   /lib/modules/uvcvideo.ko trace=255
>
> and i see, this modul is loaded.
> When i connect the camera with OTG Host cable to Android device, i see in
> dmesg:
>
>
> [  237.726595] usb 2-1.3: new high speed USB device using s3c_otghcd and
> address 3
> [  237.754590] uvcvideo: Probing generic UVC device 1.3
> [  237.754645] uvcvideo: Found format YUV 4:2:2 (YUYV).
> [  237.754671] uvcvideo: - 640x480 (30.0 fps)
> [  237.754690] uvcvideo: - 800x600 (15.0 fps)
> [  237.754709] uvcvideo: - 1024x768 (15.0 fps)
> [  237.754728] uvcvideo: - 1280x1024 (10.0 fps)
> [  237.754747] uvcvideo: - 352x288 (30.0 fps)
> [  237.754765] uvcvideo: - 320x240 (30.0 fps)
> [  237.754782] uvcvideo: - 176x144 (30.0 fps)
> [  237.754801] uvcvideo: - 160x120 (30.0 fps)
> [  237.754819] uvcvideo: - 640x480 (10.0 fps)
> [  237.754837] uvcvideo: - 640x480 (10.0 fps)
> [  237.754877] uvcvideo: Found a Status endpoint (addr 83).
> [  237.754902] uvcvideo: Found UVC 1.00 device USB 2.0 PC Cam (090c:b371)
> [  237.754926] uvcvideo: Forcing device quirks to 0x10 by module parameter
> for testing purpose.
> [  237.754950] uvcvideo: Please report required quirks to the
> linux-uvc-devel mailing list.
> [  237.754996] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/2 to device 1.3 entity 3
> [  237.755027] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/3 to device 1.3 entity 3
> [  237.755056] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/6 to device 1.3 entity 3
> [  237.755086] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/7 to device 1.3 entity 3
> [  237.755115] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/8 to device 1.3 entity 3
> [  237.755144] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/9 to device 1.3 entity 3
> [  237.755177] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/4 to device 1.3 entity 3
> [  237.755206] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000101/5 to device 1.3 entity 3
> [  237.755243] uvcvideo: Added control
> 00000000-0000-0000-0000-000000000001/3 to device 1.3 entity 1
> [  237.755278] uvcvideo: Scanning UVC chain: OT 4<- PU 3<- XU 2<- IT 1
> [  237.755328] uvcvideo: Found a valid video chain (1 ->  4).
>
> [  242.766398] uvcvideo: Failed to set UVC probe control : -104 (exp. 26).
> [  247.766677] uvcvideo: Failed to query (129) UVC probe control : -104
> (exp. 26).
> [  247.766863] uvcvideo: Failed to initialize the device (-5).
>
> Why can not i initialize the camera?
>
>
> When i use the camera on the Ubuntu, the next is the log of dmesg:
>
> 39105.367196] uvcvideo: Found a valid video chain (1 ->  4).
> [39105.470991] input: USB 2.0 PC Cam as
> /devices/pci0000:00/0000:00:02.1/usb1/1-5/1-5:1.0/input/input9
> [39105.471069] uvcvideo: UVC device initialized.
>
> My kernel version on Android is : 2.6.35.7. (i could see this is the newest
> kernel from my device)
>
> Can you help me, what is the fault?
>
> I have tried debug, i see, this function return bad:
>
> int uvc_video_init(struct uvc_streaming *stream)
>
> Thank you for your help, Szabolcs

This error was get by
drivers/media/video/uvc/uvc_video.c:uvc_set_video_ctrl()

Error -104 mean ECONNRESET
see for error numbers:
include/asm-generic/errno.h

and it was send by usb_unlink_urb()
see for usb error codes:
Documentation/usb/error-codes.txt

Uvcvideo driver never calls usb_unlink_urb(). I assume it was made by
usb host controller driver. Some where here drivers/usb/*
You will need to find why it was called. May be it is some software or
hardware bug.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Linux-uvc-devel mailing list
Linux-uvc-devel at lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-uvc-devel

Hi Kispal,

On Tuesday 27 March 2012 23:50:38 Kispal Szabolcs wrote:
> Hi,
>
> my email was rejected.... Can you help me?

You should subscribe to the linux-uvc-devel mailing list to post messages.

> On Tue, 27 Mar 2012 23:24:06 +0200 Kispal Szabolcs wrote:
> > Hello,
> > can You help me?
> >
> > Sorry my bad english. :)
> >
> > I have a camera. I use this on linux pc. ( ubuntu 10.04.04) . On Linux PC
> > work correct. I use this camera with VLC, and i see the videostream from
> > camera. I attach lsusb output.
> >
> > I want to use this camera on Android phone. This phone is Samsung Galaxy
> > Note. I compiled my own  kernel from samsung opensource with uvcvideo as
> > modul.
> >
> > I can load the modul on Android device:
> > insmod   /lib/modules/uvcvideo.ko trace=255
> >
> > and i see, this modul is loaded.
> > When i connect the camera with OTG Host cable to Android device, i see in
> > dmesg:
> >
> >
> > [  237.726595] usb 2-1.3: new high speed USB device using s3c_otghcd and
> > address 3

[snip]

> > [  242.766398] uvcvideo: Failed to set UVC probe control : -104 (exp. 26).
> > [  247.766677] uvcvideo: Failed to query (129) UVC probe control : -104
> > (exp. 26).
> > [  247.766863] uvcvideo: Failed to initialize the device (-5).
> >
> > Why can not i initialize the camera?

-104 is -ECONNRESET. This is a low-level USB issue, possibly related to your
USB controller. I'm afraid I have no experience with the S3C USB OTG
controller. You might have more luck on the linux-usb mailing list (make sure
you mention s3c_otghcd and ECONNRESET in your mail subject).
-------------- next part --------------

Bus 001 Device 007: ID 090c:b371 Feiya Technology Corp. Silicon Motion SM371 Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x090c Feiya Technology Corp.
  idProduct          0xb371 Silicon Motion SM371 Camera
  bcdDevice            1.00
  iManufacturer           1 Image Processor
  iProduct                2 USB 2.0 PC Cam
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          685
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0 
      iInterface              0 
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.00
        wTotalLength           77
        dwClockFrequency       30.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0 
        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x00000004
          Auto-Exposure Priority
      VideoControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 2
        guidExtensionCode         {92423946-d10c-e34a-8783-3133f9eaaa3b}
        bNumControl             3
        bNrPins                 1
        baSourceID( 0)          1
        bControlSize            1
        bmControls( 0)       0xff
        iExtension              0 
      VideoControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
      Warning: Descriptor too short
        bUnitID                 3
        bSourceID               2
        wMaxMultiplier          0
        bControlSize            2
        bmControls     0x0000063f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          Gain
          Power Line Frequency
        iProcessing             0 
        bmVideoStandards     0x 9
          None
          SECAM - 625/50
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              16
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      VideoStreaming Interface Descriptor:
        bLength                            14
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         1
        wTotalLength                      497
        bEndPointAddress                  129
        bmInfo                              0
        bTerminalLink                       4
        bStillCaptureMethod                 2
        bTriggerSupport                     1
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                    27
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        1
        bNumFrameDescriptors               10
        guidFormat                            {59555932-0000-1000-8000-00aa00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 1 fields
          Field 1 first: No
          Field pattern: Field 1 only
          bCopyProtect                      0
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            500000
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         2
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            800
        wHeight                           600
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      960000
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  4
        dwFrameInterval( 0)            666666
        dwFrameInterval( 1)           1000000
        dwFrameInterval( 2)           1333332
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         3
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1024
        wHeight                           768
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize     1572864
        dwDefaultFrameInterval         666666
        bFrameIntervalType                  4
        dwFrameInterval( 0)            666666
        dwFrameInterval( 1)           1000000
        dwFrameInterval( 2)           1333332
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         4
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                           1280
        wHeight                          1024
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize     2621440
        dwDefaultFrameInterval        1000000
        bFrameIntervalType                  4
        dwFrameInterval( 0)           1000000
        dwFrameInterval( 1)           1333332
        dwFrameInterval( 2)           2000000
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         5
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            352
        wHeight                           288
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      202752
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            500000
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         6
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            500000
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         7
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            176
        wHeight                           144
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize       50688
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            500000
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         8
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            160
        wHeight                           120
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize       38400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  4
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            500000
        dwFrameInterval( 2)            666666
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         9
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval        1000000
        bFrameIntervalType                  4
        dwFrameInterval( 0)           1000000
        dwFrameInterval( 1)           1333332
        dwFrameInterval( 2)           2000000
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            42
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                        10
        bmCapabilities                   0x00
          Still image unsupported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                   912384
        dwMaxBitRate                   912384
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval        1000000
        bFrameIntervalType                  4
        dwFrameInterval( 0)           1000000
        dwFrameInterval( 1)           1333332
        dwFrameInterval( 2)           2000000
        dwFrameInterval( 3)          10000000
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  3 (STILL_IMAGE_FRAME)
        bEndpointAddress                    0
        bNumImageSizePatterns               6
        wWidth( 0)                        640
        wHeight( 0)                       480
        wWidth( 1)                        352
        wHeight( 1)                       288
        wWidth( 2)                        320
        wHeight( 2)                       240
        wWidth( 3)                        176
        wHeight( 3)                       144
        wWidth( 4)                        160
        wHeight( 4)                       120
        wWidth( 5)                       1280
        wHeight( 5)                      1024
        bNumCompressionPatterns             6
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     0 (Unspecified)
        bTransferCharacteristics            0 (Unspecified)
        bMatrixCoefficients                 0 (Unspecified)
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1340  3x 832 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1300  3x 768 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x12c0  3x 704 bytes
        bInterval               1
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)
