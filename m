From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 2 Sep 2014 10:06:16 -0700
Subject: [PATCH v3 4/4] pinctrl: qcom: Add support for reset for apq8064
In-Reply-To: <CACRpkdbnkgb2YOKAPTFSaDhj7OMbfF+14_PeDch5mFLwjOANEw@mail.gmail.com>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>
 <1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>
 <CACRpkdbnkgb2YOKAPTFSaDhj7OMbfF+14_PeDch5mFLwjOANEw@mail.gmail.com>
Message-ID: <20140902170615.GO12494@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 02 Sep 05:36 PDT 2014, Linus Walleij wrote:

> A bit dirty to have this in this driver, but who cares.
> 

Indeed, but we figured the taint was small enough to justify not creating
cross-references to a separate driver.

> Does the APQ8064 accompanying PMIC also have the ability to
> completely shut the system down?
> 

Upon flipping pshold the PMIC will perform either a reset or a shutdown of the
system. Per Stephen's suggestion we can hook the control of this up with a
reboot_notifier in a pmic driver, hence saving ourselves of a reference to (or
from) the PMIC here.

Regards,
Bjorn
