From: jacobchen110@gmail.com (Jacob Chen)
Date: Mon, 11 Sep 2017 18:47:51 +0800
Subject: [PATCH v8 0/4] Add Rockchip RGA V4l2 support
In-Reply-To: <1505126644-18396-1-git-send-email-jacob-chen@iotwrt.com>
References: <1505126644-18396-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <CAFLEztQZVJycPydqUKF8ysvL0BceS5U6_zDLDctzYFuiVS+jqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

v4l2-compliance result:

v4l2-compliance SHA   : not available

Driver Info:
        Driver name   : rockchip-rga
        Card type     : rockchip-rga
        Bus info      : platform:rga
        Driver version: 4.13.0
        Capabilities  : 0x84208000
                Video Memory-to-Memory
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps   : 0x04208000
                Video Memory-to-Memory
                Streaming
                Extended Pix Format

Compliance test for device /dev/video0 (not using libv4l2):

Required ioctls:
        test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
        test second video open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

        Control ioctls:
                test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
                test VIDIOC_QUERYCTRL: OK
                test VIDIOC_G/S_CTRL: OK
                test VIDIOC_G/S/TRY_EXT_CTRLS: OK
                test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
                test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
                Standard Controls: 7 Private Controls: 0

        Format ioctls:
                test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                test VIDIOC_G/S_PARM: OK (Not Supported)
                test VIDIOC_G_FBUF: OK (Not Supported)
                test VIDIOC_G_FMT: OK
                test VIDIOC_TRY_FMT: OK
                fail: v4l2-test-formats.cpp(779):
fmt_cap.g_colorspace() != col
                test VIDIOC_S_FMT: FAIL
                test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
                fail: v4l2-test-formats.cpp(1273): doioctl(node,
VIDIOC_G_SELECTION, &sel) != EI
NVAL
                test Cropping: OK (Not Supported)
                fail: v4l2-test-formats.cpp(1273): doioctl(node,
VIDIOC_G_SELECTION, &sel) != EI
NVAL
                test Composing: FAIL
                test Scaling: OK

        Codec ioctls:
                test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
                test VIDIOC_G_ENC_INDEX: OK (Not Supported)
                test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

        Buffer ioctls:
                test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
                test VIDIOC_EXPBUF: OK

Test input 0:


Total: 43, Succeeded: 41, Failed: 2, Warnings: 0
root at linaro-alip:~#
