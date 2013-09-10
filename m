From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 10 Sep 2013 18:54:46 +0200
Subject: [RESEND PATCH v2] pwm: pxa: add device tree support to pwm driver
In-Reply-To: <522F4CF9.3070601@wwwdotorg.org>
References: <1378751420-19227-1-git-send-email-mikedunn@newsguy.com>
 <522E3B5B.90406@wwwdotorg.org> <522F40A3.9030701@newsguy.com>
 <522F4CF9.3070601@wwwdotorg.org>
Message-ID: <20130910165445.GA22111@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 10:46:49AM -0600, Stephen Warren wrote:
> On 09/10/2013 09:54 AM, Mike Dunn wrote:
> > On 09/09/2013 02:19 PM, Stephen Warren wrote:
> >> On 09/09/2013 12:30 PM, Mike Dunn wrote:
[...]
> >>> +- reg: physical base address and length of the registers used by the pwm channel
> >>> +  NB: One device instance must be created for each pwm that is used, so the
> >>> +  length covers only the register window for one pwm output, not that of the
> >>> +  entire pwm controller.  Currently length is 0x10 for all supported devices.
> >>> +- #pwm-cells: should be 3.
> >>> +   cell 1: the per-chip index of the PWM to use,
> >>
> >> That cell shouldn't be needed if you really want to have one DT node per
> >> PWM channel.
> > 
> > Yes, but I was afraid to deviate from the format used by the other PWM
> > controllers.  (But in that case, it should at least be documented as "must be
> > zero". Thanks.)  If going my owm way is acceptable, I'll define my own
> > of_xlate() parser and remove this cell.
> 
> I don't think there's any issue with deviating; that's exactly what
> #pwm-cells is for.

Agreed, I have no objections to using a custom .of_xlate().

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/f91e6adc/attachment.sig>
