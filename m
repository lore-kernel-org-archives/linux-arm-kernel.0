From: smitha.t@samsung.com (Smitha T Murthy)
Date: Wed, 13 Dec 2017 14:00:01 +0530
Subject: [Patch v6 10/12] [media] v4l2: Add v4l2 control IDs for HEVC
 encoder
In-Reply-To: <10a80dd4-737d-2c96-1679-3b04cfc45a5d@samsung.com>
References: <1512724105-1778-1-git-send-email-smitha.t@samsung.com>
 <CGME20171208093702epcas2p32a30a9f624e06fb543f7dd757c805077@epcas2p3.samsung.com>
 <1512724105-1778-11-git-send-email-smitha.t@samsung.com>
 <5b96b332-71a9-083a-2242-8bdf5554f010@linaro.org>
 <1513046086.22129.2.camel@smitha-fedora>
 <10a80dd4-737d-2c96-1679-3b04cfc45a5d@samsung.com>
Message-ID: <1513153801.22129.5.camel@smitha-fedora>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 10:46 +0100, Sylwester Nawrocki wrote:
> On 12/12/2017 03:34 AM, Smitha T Murthy wrote:
> >> s/Lay/Layer here and below
> >>
> > Ok I will change it.
> 
> While it's fine to make such change for controls up to V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_QP...
> 
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_QP:	return "HEVC Hierarchical Lay 1 QP";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_QP:	return "HEVC Hierarchical Lay 2 QP";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_QP:	return "HEVC Hierarchical Lay 3 QP";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_QP:	return "HEVC Hierarchical Lay 4 QP";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_QP:	return "HEVC Hierarchical Lay 5 QP";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_QP:	return "HEVC Hierarchical Lay 6 QP";
> 
> ...for the controls below we may need to replace "Lay" with "L." 
> to make sure the length of the string don't exceed 31 characters 
> (32 with terminating NULL). The names below seem to be 1 character 
> too long and will be truncated when running VIDIOC_QUERY_CTRL ioctl.
> 
Yes true, also to keep the uniformity I will change for all
V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_QP and
V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_BR "Lay" with "L".

> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_BR:	return "HEVC Hierarchical Lay 0 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_BR:	return "HEVC Hierarchical Lay 1 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_BR:	return "HEVC Hierarchical Lay 2 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_BR:	return "HEVC Hierarchical Lay 3 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_BR:	return "HEVC Hierarchical Lay 4 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_BR:	return "HEVC Hierarchical Lay 5 Bit Rate";
> >>> +	case V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_BR:	return "HEVC Hierarchical Lay 6 Bit Rate";
> 
> --
> Regards,
> Sylwester
> 
Thank you for the review.

Regards,
Smitha
