From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 23 Feb 2015 09:49:13 -0800
Subject: [PATCH 1/2] Input: bcm-keypad: add device tree bindings
In-Reply-To: <20150216051751.GA15948@dtor-ws>
References: <sbranden@broadcom.com>
 <1423526861-29579-1-git-send-email-sbranden@broadcom.com>
 <1423526861-29579-2-git-send-email-sbranden@broadcom.com>
 <20150210005134.GA13695@dtor-ws> <54DF7C8B.3050103@broadcom.com>
 <20150216051751.GA15948@dtor-ws>
Message-ID: <20150223174913.GB604@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Sun, Feb 15, 2015 at 09:17:51PM -0800, Dmitry Torokhov wrote:
> On Sat, Feb 14, 2015 at 08:49:15AM -0800, Scott Branden wrote:
> > On 15-02-09 04:51 PM, Dmitry Torokhov wrote:
> > >On Mon, Feb 09, 2015 at 04:07:40PM -0800, Scott Branden wrote:
> > >>+
> > >>+- col-debounce-filter-period: The debounce period for the Column filter.
> > >>+
> > >>+	KEYPAD_DEBOUNCE_1_ms	=	0
> > >>+	KEYPAD_DEBOUNCE_2_ms	=	1
> > >>+	KEYPAD_DEBOUNCE_4_ms	=	2
> > >>+	KEYPAD_DEBOUNCE_8_ms	=	3
> > >
> > >>+	KEYPAD_DEBOUNCE_16_ms	=	4
> > >>+	KEYPAD_DEBOUNCE_32_ms	=	5
> > >>+	KEYPAD_DEBOUNCE_64_ms	=	6
> > >>+	KEYPAD_DEBOUNCE_128_ms	=	7
> > >>+
> > >>+- status-debounce-filter-period: The debounce period for the Status filter.
> > >>+
> > >>+	KEYPAD_DEBOUNCE_1_ms	=	0
> > >>+	KEYPAD_DEBOUNCE_2_ms	=	1
> > >>+	KEYPAD_DEBOUNCE_4_ms	=	2
> > >>+	KEYPAD_DEBOUNCE_8_ms	=	3
> > >>+	KEYPAD_DEBOUNCE_16_ms	=	4
> > >>+	KEYPAD_DEBOUNCE_32_ms	=	5
> > >>+	KEYPAD_DEBOUNCE_64_ms	=	6
> > >>+	KEYPAD_DEBOUNCE_128_ms	=	7
> > >
> > >I could swear device-specific properties should be in form of
> > ><vendor-prefix>,<property-name> to ensure it won't clash with changes on
> > >subsystem level later on. Device-tree folks, what say you?
> > I see examples with and without vendor-prefix.
> > qcom,pm8xxx-keypad.txt does not have prefixes
> > st-keyscan.txt does have a prefix
> > 
> > I can't find any documented guidelines for this.
> 
> As I mentioned I'll try to get clarification on this.

I have chatted with a couple of people on this and it is acceptable to
omit vendor prefix in bindings when we are using a specific driver like
we have here (i.e. when driver's compatible string already includes
vendor prefix). Vendor prefixes on properties are required when we
augment a generic driver's binding.

So the above 2 entries are fine as is.

Thanks.

-- 
Dmitry
