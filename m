From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 24 Jan 2017 18:39:30 -0800
Subject: [PATCH v3 19/24] media: imx: Add IC subdev drivers
In-Reply-To: <07f4bc9e-22ef-a925-f4ee-c14df65e4f0d@xs4all.nl>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-20-git-send-email-steve_longerbeam@mentor.com>
 <07f4bc9e-22ef-a925-f4ee-c14df65e4f0d@xs4all.nl>
Message-ID: <aa230b31-39f0-524d-3ce5-05827360ea95@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/20/2017 06:29 AM, Hans Verkuil wrote:
> On 01/07/2017 03:11 AM, Steve Longerbeam wrote:
>> +
>> +static const struct v4l2_ctrl_config prpenc_std_ctrl[] = {
>> +	{
>> +		.id = V4L2_CID_HFLIP,
>> +		.name = "Horizontal Flip",
>> +		.type = V4L2_CTRL_TYPE_BOOLEAN,
>> +		.def =  0,
>> +		.min =  0,
>> +		.max =  1,
>> +		.step = 1,
>> +	}, {
>> +		.id = V4L2_CID_VFLIP,
>> +		.name = "Vertical Flip",
>> +		.type = V4L2_CTRL_TYPE_BOOLEAN,
>> +		.def =  0,
>> +		.min =  0,
>> +		.max =  1,
>> +		.step = 1,
>> +	}, {
>> +		.id = V4L2_CID_ROTATE,
>> +		.name = "Rotation",
>> +		.type = V4L2_CTRL_TYPE_INTEGER,
>> +		.def =   0,
>> +		.min =   0,
>> +		.max = 270,
>> +		.step = 90,
>> +	},
>> +};
> Use v4l2_ctrl_new_std() instead of this array: this avoids duplicating information
> like the name and type.
>
> If this is also done elsewhere, then it should be changed there as well.

done.

Steve
