From: federico.vaga@gmail.com (Federico Vaga)
Date: Thu, 10 Jan 2013 13:57:19 +0100
Subject: [PATCH v5 2/3] sta2x11_vip: convert to videobuf2 and control
 framework
In-Reply-To: <1357822010-30419-3-git-send-email-federico.vaga@gmail.com>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
 <1357822010-30419-3-git-send-email-federico.vaga@gmail.com>
Message-ID: <3596574.18Q2Rh4jo9@harkonnen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

@Hans: here the output of v4l2-compliance that you request me for the v4 
version. This is done on the v5 version where I applied your suggestion. I 
have 1 warning but I don't understand where is the problem

Driver Info:
	Driver name   : sta2x11_vip
	Card type     : sta2x11_vip
	Bus info      : PCI:0000:06:00.0
	Driver version: 3.6.0
	Capabilities  : 0x85000001
		Video Capture
		Read/Write
		Streaming
		Device Capabilities
	Device Caps   : 0x05000001
		Video Capture
		Read/Write
		Streaming

Compliance test for device /dev/video0 (not using libv4l2):

Required ioctls:
	test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
	test second video open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK

Debug ioctls:
	test VIDIOC_DBG_G_CHIP_IDENT: Not Supported
	test VIDIOC_DBG_G/S_REGISTER: Not Supported
	test VIDIOC_LOG_STATUS: OK

Input ioctls:
	test VIDIOC_G/S_TUNER: Not Supported
	test VIDIOC_G/S_FREQUENCY: Not Supported
	test VIDIOC_S_HW_FREQ_SEEK: OK
	test VIDIOC_ENUMAUDIO: Not Supported
	test VIDIOC_G/S/ENUMINPUT: OK
	test VIDIOC_G/S_AUDIO: Not Supported
	Inputs: 2 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: Not Supported
	test VIDIOC_G/S_FREQUENCY: Not Supported
	test VIDIOC_ENUMAUDOUT: Not Supported
	test VIDIOC_G/S/ENUMOUTPUT: Not Supported
	test VIDIOC_G/S_AUDOUT: Not Supported
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Control ioctls:
	test VIDIOC_QUERYCTRL/MENU: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: Not Supported
	Standard Controls: 5 Private Controls: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK
	test VIDIOC_ENUM/G/S/QUERY_DV_PRESETS: Not Supported
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: Not Supported
	test VIDIOC_DV_TIMINGS_CAP: Not Supported

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK
	test VIDIOC_G_FBUF: Not Supported
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: Not Supported

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS: OK
	test read/write: OK

Total: 36, Succeeded: 36, Failed: 0, Warnings: 1


-- 
Federico Vaga
