From: dianders@chromium.org (Doug Anderson)
Date: Thu, 29 Mar 2018 15:36:33 -0700
Subject: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
Message-ID: <CAD=FV=WHzqL1cPdb5Q9E8nXzV=SNXA-r5hWXidf+W3Eh_Sirng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 21, 2018 at 12:07 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> +static int rpmh_regulator_remove(struct platform_device *pdev)
>> +{
>> +       struct rpmh_pmic *pmic = platform_get_drvdata(pdev);
>> +
>> +       rpmh_release(pmic->rpmh_client);
>
> I'm still lost on what rpmh_client is giving us besides more code we
> don't need. I'll ping the rpmh thread again.

It's not completely obvious to me what you are asking here and I think
you didn't actually get back to pinging the RPMH thread, did you?  In
his response, David seems to have taken your comment as "I agree with
Doug, please add devm_rpmh_get_client", but I'm not sure that's what
you meant.  It sounds a lot like you're suggesting totally gutting the
concept of the "rpmh_client".

I certainly haven't reviewed RPMH a whole lot, but perhaps you can
make it more obvious how this would work.

In any case, I guess this is a bit off topic for the regulator series.
Perhaps you can respond to the RPMH series with more details about
what you're looking for?


Thanks!

-Doug
