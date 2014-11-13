From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 13 Nov 2014 10:22:18 +0000
Subject: [PATCH 07/13] ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
In-Reply-To: <20141110101131.GP21424@x1>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-8-git-send-email-peter.griffin@linaro.org>
 <20141110101131.GP21424@x1>
Message-ID: <20141113102218.GA25886@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Thanks for reviewing.

On Mon, 10 Nov 2014, Lee Jones wrote:
> > +			reg =	<0xf8 0x04>,	/* syscfg 5062 */
> > +				<0xf4 0x04>;    /* syscfg 5061 */
> 
> Are there really only 2 32bit registers to control this h/w?

Yes

> 
> > +			reg-names =	"param",
> > +					"ctrl";
> 
> Superflous indentation after 'reg = ' and 'reg-names = '.

Fixed in v2.

> > +			st,syscfg = <&syscfg_core>;
> > +			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> > +				 <&picophyreset STIH407_PICOPHY0_RESET>;
> > +			reset-names = "global",
> > +				      "port";
> 
> May as well put these on the same line.

Fixed in v2.

regards,

Peter.
