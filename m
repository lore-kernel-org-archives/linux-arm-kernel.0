From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Sep 2018 11:07:21 +0200
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
 <20180918075522.GC22202@nazgul.tnic>
 <DM6PR02MB5227F5B1B329C903BA64A27CC11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
 <20180919111553.GA9140@nazgul.tnic>
 <DM6PR02MB52279753E7FD04587393DC08C11C0@DM6PR02MB5227.namprd02.prod.outlook.com>
Message-ID: <20180921090721.GB30439@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 01:33:58PM +0000, Manish Narani wrote:
> Apart from this one, I have covered all the comments from the previous review.

Are you sure?

Let's see. I said:

| Kill all that "function pointer" fluff. Here's how I've changed it:
| 
| /**
|  * struct synps_platform_data -  synps platform data structure
|  * @edac_geterror_info: edac error info
|  * @edac_get_mtype:     get mtype
|  * @edac_get_dtype:     get dtype
|  * @edac_get_eccstate:  get ECC state
			  ^^^^^^^^^^^^^

This is supposed to denote that this function returns whether ECC
checking is enabled on the controller or not.

Your patch has:

+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:     Get error info.
+ * @get_mtype:         Get mtype.
+ * @get_dtype:         Get dtype.
+ * @get_eccstate:      Get eccstate.

So what is "eccstate"? Is it a struct or a variable or ...?

Do you see my point?

I know, it is a small thing but documenting our code properly is
something which people would be thanking us for. Even you will be
thanking yourself when you look at this months from now after having
forgotten it all.

Please check the rest of your additions for similar discrepancies.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
